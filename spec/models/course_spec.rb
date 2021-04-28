require "rails_helper"
require "rspec/collection_matchers"
require "shoulda-matchers"

RSpec.describe Course, type: :model do
  let(:course) {FactoryBot.create :course}
  subject {course}

  it "is a Course" do
    is_expected.to be_a_kind_of Course
  end

  it "is valid with all correct informations" do
    expect(course).to be_valid
  end

  describe "associations" do
    it "has many course subjects" do
      is_expected.to have_many(:course_subjects).dependent :destroy
    end

    it "has many subjects" do
      is_expected.to have_many(:subjects).through :course_subjects
    end

    it "has many trainees" do
      is_expected.to have_many(:trainees).through :user_courses
    end

    it "has many user course" do
      is_expected.to have_many(:user_courses).dependent :destroy
    end
  end

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :end_date }
  it { is_expected.to have_many :subjects }
end
