module ApplicationHelper
  def logout_button
    form =  "<form action=\"/session\" method=\"post\">"
    form += "<input type=\"hidden\" value=\"DELETE\" name=\"_method\">"
    form += "<input type=\"submit\" value=\"Logout!\">"
    form += "</form>"
    form.html_safe
  end
end
