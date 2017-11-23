Rails.application.routes.draw do
  root to: "dummy#dummy"

  get "about" => "dummy#dummy", as: :about
end
