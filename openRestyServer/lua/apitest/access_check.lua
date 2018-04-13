local args = ngx.req.get_uri_args()

if not args.a or not args.b or not tonumber(args.a) or not tonumber(args.b)  then
    ngx.exit(ngx.HTTP_BAD_REQUEST)
    return
end


