crumb :root do
  link "Home", root_url
end

crumb :without_link do
  link "Breadcrumb without link"
end

crumb :with_root do
  link "About", about_path(foo: 'bar')
  parent :without_link
end
