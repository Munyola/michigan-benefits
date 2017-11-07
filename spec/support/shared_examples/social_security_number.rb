RSpec.shared_examples "social security number" do
  describe "social security number" do
    it "allows nils" do
      subject.ssn = nil
      expect(subject).to be_valid
    end

    it "allows ssn to start with zero" do
      subject.ssn = "012345678"
      expect(subject).to be_valid
    end

    it "allows ssns with no delimiters" do
      subject.ssn = "123456789"
      expect(subject).to be_valid
    end

    it "disallows bogus ssns" do
      subject.ssn = "BOGUS"
      expect(subject).not_to be_valid
    end

    it "invalidates bad SSNs with a friendly message" do
      subject.ssn = "113 12 2345"
      expect(subject).not_to be_valid
      expect(subject.errors[:ssn]).to include(
        "Make sure to provide 9 digits",
      )
    end

    it "disallows bogus ssns with newlines" do
      subject.ssn = "BOGUS\n'--DROP TABLE CALFRESH_APPLICATIONS"
      expect(subject).not_to be_valid
    end

    it "does not allow dashes" do
      subject.ssn = "123-45-6789"
      expect(subject).to be_invalid
      expect(subject.errors[:ssn]).to include(
        "Make sure to provide 9 digits",
      )
    end
  end
end
