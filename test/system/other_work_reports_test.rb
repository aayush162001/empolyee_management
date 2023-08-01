require "application_system_test_case"

class OtherWorkReportsTest < ApplicationSystemTestCase
  setup do
    @other_work_report = other_work_reports(:one)
  end

  test "visiting the index" do
    visit other_work_reports_url
    assert_selector "h1", text: "Other work reports"
  end

  test "should create other work report" do
    visit other_work_reports_url
    click_on "New other work report"

    click_on "Create Other work report"

    assert_text "Other work report was successfully created"
    click_on "Back"
  end

  test "should update Other work report" do
    visit other_work_report_url(@other_work_report)
    click_on "Edit this other work report", match: :first

    click_on "Update Other work report"

    assert_text "Other work report was successfully updated"
    click_on "Back"
  end

  test "should destroy Other work report" do
    visit other_work_report_url(@other_work_report)
    click_on "Destroy this other work report", match: :first

    assert_text "Other work report was successfully destroyed"
  end
end
