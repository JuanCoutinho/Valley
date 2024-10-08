require 'rails_helper'

RSpec.describe "projects/new", type: :view do
  before(:each) do
    assign(:project, Project.new(
      title: "MyString", # rubocop:disable Layout/FirstArgumentIndentation
      ds_project: "MyText"
    ))
  end

  it "renders new project form" do
    render

    assert_select "form[action=?][method=?]", projects_path, "post" do
      assert_select "input[name=?]", "project[title]"

      assert_select "textarea[name=?]", "project[ds_project]"
    end
  end
end
