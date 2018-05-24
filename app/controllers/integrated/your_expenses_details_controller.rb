module Integrated
  class YourExpensesDetailsController < FormsController
    include ManyExpensesDetails
    extend ManyExpensesDetails::ClassMethods

    def self.expenses_scope
      :court_ordered_or_other
    end
  end
end
