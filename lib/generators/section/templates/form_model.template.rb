class <%= model.camelcase %>Form < Form

  <%- if options.doc? -%>
  # Whitelist top-level parameter names for CommonApplication, e.g.
  #
  #   given params: { form: {
  #      living_situation: "stable_housing",
  #      members: { "1" => { first_name: "Christa" } }
  #   }}
  #
  #   set_application_attributes(:living_situation, :members)
  #
  # Delete the method if you aren't updating the CommonApplication.
  <%- end -%>
  set_application_attributes()

  <%- if options.doc? -%>
  # Whitelist top-level parameter names for a single HouseholdMember, e.g.
  #
  #   given params: { form: { first_name: "value", last_name: "value" } }
  #
  #   set_member_attributes(:first_name, :last_name)
  #
  # Delete the method if you aren't updating a single HouseholdMember.
  <%- end -%>
  set_member_attributes()
end
