require "rails_helper"

RSpec.describe Medicaid::ContactOtherAddressController, type: :controller do
  describe "#next_path" do
    it "is the contact mailing address page path" do
      expect(subject.next_path).to eq "/steps/medicaid/contact-mailing-address"
    end
  end

  describe "#edit" do
    context "mail is sent to residential address" do
      it "redirects to next page" do
        medicaid_application = create(
          :medicaid_application,
          mail_sent_to_residential: true,
        )
        session[:medicaid_application_id] = medicaid_application.id

        get :edit

        expect(response).to redirect_to(subject.next_path)
      end
    end

    context "mail not sent to residential address" do
      it "renders the edit page" do
        medicaid_application = create(
          :medicaid_application,
          mail_sent_to_residential: false,
        )
        session[:medicaid_application_id] = medicaid_application.id

        get :edit

        expect(response).to render_template(:edit)
      end
    end
  end
end
