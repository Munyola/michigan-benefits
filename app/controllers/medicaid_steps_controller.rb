class MedicaidStepsController < StepsController
  helper_method :single_member_household?

  def current_application
    MedicaidApplication.find_by(id: current_medicaid_application_id)
  end

  def application_title
    "Medicaid Application"
  end

  def current_medicaid_application_id
    session[:medicaid_application_id]
  end

  def step_navigation
    @step_navigation ||= Medicaid::StepNavigation.new(self)
  end

  private

  def first_step_path
    medicaid_intro_location_steps_path
  end
end
