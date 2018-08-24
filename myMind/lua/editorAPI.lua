
local P = {}
editorAPI = P

setmetatable(P, {__index = _G})
setfenv(1, P)

local api = {
    [ '/upload' ] = true ,
}

function isEditorAPI( path ) 
    return api[ path ]
end

return editorAPI


