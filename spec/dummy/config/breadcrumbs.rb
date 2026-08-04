crumb :root do
  link "Home", root_url
end

crumb :with_root do
  link "About", about_url(foo: "bar")
end

crumb :with_xss_payload do
  link "</script><script>alert(1)</script>", "/xss"
end
