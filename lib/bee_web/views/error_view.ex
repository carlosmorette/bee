defmodule BeeWeb.ErrorView do
  use BeeWeb, :view

  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end

  # def render("404.html", _assigns) do
  #   # your code here...
  # end

  # def render("500.html", _assigns) do
  #   # your code here...
  # end
end
