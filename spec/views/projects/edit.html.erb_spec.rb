require 'rails_helper'

RSpec.describe "projects/edit", type: :view do
  let(:project) do
    Project.create!(
      title: "MyString",
      ds_project: "MyText"
    )
  end

  before(:each) do
    assign(:project, project)
  end

  it "renders the edit project form" do
    render

    assert_select "form[action=?][method=?]", project_path(project), "post" do
      assert_select "input[name=?]", "project[title]"

      assert_select "textarea[name=?]", "project[ds_project]"
    end
  end
end
