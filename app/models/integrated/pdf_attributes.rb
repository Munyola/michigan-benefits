module Integrated
  module PdfAttributes
    CIRCLED = "O".freeze
    UNDERLINED = "------------".freeze

    def yes_no_or_unfilled(yes: nil, no: nil)
      if yes
        "Yes"
      elsif no
        "No"
      end
    end

    def underline_if_true(statement)
      UNDERLINED if statement
    end

    def circle_if_true(statement)
      CIRCLED if statement
    end

    def mmddyyyy_date(date)
      date&.strftime("%m/%d/%Y")
    end

    def member_names(members)
      members.map(&:display_name).join(", ")
    end
  end
end
