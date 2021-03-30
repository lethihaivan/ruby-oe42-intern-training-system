module CourseSubjectsHelper
  def load_subjects
    @subjects = Subject.ordered_by_name.pluck(:name, :id)
  end
end
