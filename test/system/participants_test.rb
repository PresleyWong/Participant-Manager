require "application_system_test_case"

class ParticipantsTest < ApplicationSystemTestCase
  setup do
    @participant = participants(:one)
  end

  test "visiting the index" do
    visit participants_url
    assert_selector "h1", text: "Participants"
  end

  test "creating a Participant" do
    visit participants_url
    click_on "New Participant"

    fill_in "Academic year", with: @participant.academic_year
    fill_in "Chinese name", with: @participant.chinese_name
    fill_in "College", with: @participant.college
    fill_in "Email", with: @participant.email
    fill_in "English name", with: @participant.english_name
    fill_in "Gender", with: @participant.gender
    fill_in "Language", with: @participant.language
    fill_in "Phone", with: @participant.phone
    fill_in "Remarks", with: @participant.remarks
    click_on "Create Participant"

    assert_text "Participant was successfully created"
    click_on "Back"
  end

  test "updating a Participant" do
    visit participants_url
    click_on "Edit", match: :first

    fill_in "Academic year", with: @participant.academic_year
    fill_in "Chinese name", with: @participant.chinese_name
    fill_in "College", with: @participant.college
    fill_in "Email", with: @participant.email
    fill_in "English name", with: @participant.english_name
    fill_in "Gender", with: @participant.gender
    fill_in "Language", with: @participant.language
    fill_in "Phone", with: @participant.phone
    fill_in "Remarks", with: @participant.remarks
    click_on "Update Participant"

    assert_text "Participant was successfully updated"
    click_on "Back"
  end

  test "destroying a Participant" do
    visit participants_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Participant was successfully destroyed"
  end
end
