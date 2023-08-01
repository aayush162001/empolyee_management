require "test_helper"

class OtherWorkReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @other_work_report = other_work_reports(:one)
  end

  test "should get index" do
    get other_work_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_other_work_report_url
    assert_response :success
  end

  test "should create other_work_report" do
    assert_difference("OtherWorkReport.count") do
      post other_work_reports_url, params: { other_work_report: {  } }
    end

    assert_redirected_to other_work_report_url(OtherWorkReport.last)
  end

  test "should show other_work_report" do
    get other_work_report_url(@other_work_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_other_work_report_url(@other_work_report)
    assert_response :success
  end

  test "should update other_work_report" do
    patch other_work_report_url(@other_work_report), params: { other_work_report: {  } }
    assert_redirected_to other_work_report_url(@other_work_report)
  end

  test "should destroy other_work_report" do
    assert_difference("OtherWorkReport.count", -1) do
      delete other_work_report_url(@other_work_report)
    end

    assert_redirected_to other_work_reports_url
  end
end
