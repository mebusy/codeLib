module.exports = {
  extends: "eslint:recommended",
  parserOptions: {
    ecmaVersion: 2020,
  },
  env: {
    es6: true,
    node: true,
    mocha: true,
  },
  rules: {
    //Possible Errors
    "no-console": "error",
    "no-template-curly-in-string": "error",

    //Best Practices
    curly: ["error", "all"],
    "no-nested-ternary": "error",
    "no-unneeded-ternary": "error",
    "no-lonely-if": "error",
    "default-case": "error",
    "dot-location": ["error", "property"],
    "dot-notation": "error",
    eqeqeq: ["error", "always"],
    "no-caller": "error",
    "no-div-regex": "error",
    "no-else-return": "error",
    "no-empty-function": "error",
    "no-extend-native": "error",
    "no-extra-bind": "error",
    "no-invalid-this": "error",
    "no-multi-spaces": "error",
    "no-multi-str": "error",
    "no-new-wrappers": "error",
    "prefer-promise-reject-errors": "error",
    yoda: "error",
    "no-undefined": "error",
    "no-use-before-define": "error",
    "no-unused-vars": [
      "error",
      {
        varsIgnorePattern: "^_",
        argsIgnorePattern: "^_",
        caughtErrorsIgnorePattern: "^_",
      },
    ],

    //Node.js and CommonJS
    "callback-return": "error",
    "handle-callback-err": "error",
    "no-path-concat": "error",
    "no-new-require": "error",

    //Stylistic Issues

    camelcase: ["error", { properties: "never" }],
    "comma-dangle": ["error", "only-multiline"],
    "comma-spacing": "error",
    "comma-style": "error",
    "func-style": ["error", "declaration"],

    //ES6
    "no-var": "error",
    "arrow-parens": ["error", "always"],
  },
};
