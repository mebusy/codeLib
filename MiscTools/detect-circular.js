#!/usr/bin/env node

// pnpm add -D acorn acorn-walk fast-glob -w

const fs = require('fs')
const path = require('path')

const fg = require('fast-glob')
const acorn = require('acorn')
const walk = require('acorn-walk')

const ROOT = path.resolve(process.argv[2] || '.')

const files = fg.sync(['**/*.js'], {
  cwd: ROOT,
  absolute: true,
  ignore: ['**/node_modules/**', '**/.git/**', 'shared/mongodb-utils/query-db-profile.js'],
})

const fileSet = new Set(files.map((f) => path.normalize(f)))
const graph = new Map()

function resolveRequire(fromFile, req) {
  if (!req.startsWith('.')) return null

  const base = path.resolve(path.dirname(fromFile), req)

  const candidates = [base, base + '.js', path.join(base, 'index.js')]

  for (const file of candidates) {
    const f = path.normalize(file)
    if (fileSet.has(f)) return f
  }

  return null
}

for (const file of files) {
  const code = fs.readFileSync(file, 'utf8')

  let ast

  try {
    ast = acorn.parse(code, {
      ecmaVersion: 'latest',
      sourceType: 'script',
      allowHashBang: true,
      locations: true,
    })
  } catch (e) {
    console.error('Parse failed:', path.relative(ROOT, file))
    continue
  }

  const deps = []

  //
  // 只遍历 Program
  //
  const base = Object.assign({}, walk.base)

  //
  // 不进入函数
  //
  base.FunctionDeclaration = () => {}
  base.FunctionExpression = () => {}
  base.ArrowFunctionExpression = () => {}

  //
  // 不进入 class method
  //
  base.MethodDefinition = (node, st, c) => {
    c(node.key, st)
  }

  walk.recursive(ast, null, {
    ...base,

    CallExpression(node, st, c) {
      if (
        node.callee.type === 'Identifier' &&
        node.callee.name === 'require' &&
        node.arguments.length === 1 &&
        node.arguments[0].type === 'Literal' &&
        typeof node.arguments[0].value === 'string'
      ) {
        const dep = resolveRequire(file, node.arguments[0].value)
        if (dep) {
          deps.push({
            file: dep,
            line: node.loc.start.line,
            column: node.loc.start.column + 1,
            code: code.split(/\r?\n/)[node.loc.start.line - 1].trim(),
          })
        }
      }

      base.CallExpression(node, st, c)
    },
  })

  graph.set(file, [...new Set(deps)])
}

const visited = new Set()
const stack = []
const inStack = new Set()
const printed = new Set()

let bCircularDepend = false
function dfs(file) {
  if (inStack.has(file)) {
    const idx = stack.indexOf(file)
    const cycle = stack.slice(idx).concat(file)

    const key = [...cycle].sort().join('|')

    if (!printed.has(key)) {
      printed.add(key)

      console.log()
      console.log('Circular:')

      bCircularDepend = true

      // for (const f of cycle) {
      //   console.log('  ' + path.relative(ROOT, f))
      // }
      for (let i = idx; i < stack.length; i++) {
        const from = stack[i]
        const to = cycle[(i - idx + 1) % cycle.length]

        const edge = graph.get(from).find((x) => x.file === to)

        console.log(`  ${path.relative(ROOT, from)}:${edge.line}:${edge.column}`)

        console.log(`      ${edge.code}`)
      }

      const last = graph.get(cycle.at(-2)).find((x) => x.file === cycle.at(-1))

      console.log(`  ${path.relative(ROOT, cycle.at(-2))}:${last.line}:${last.column}`)

      console.log(`      ${last.code}`)
    }

    return
  }

  if (visited.has(file)) return

  visited.add(file)

  inStack.add(file)
  stack.push(file)

  for (const dep of graph.get(file) || []) dfs(dep.file)

  stack.pop()
  inStack.delete(file)
}

for (const file of files) dfs(file)

if (bCircularDepend) {
  process.exit(1)
}
