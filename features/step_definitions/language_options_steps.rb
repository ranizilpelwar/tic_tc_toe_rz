require_relative '../../lib/tic_tac_toe_rz/tictactoeruby.core/languages/language_options_adapter.rb'
require_relative '../../lib/tic_tac_toe_rz/tictactoeruby.core/exceptions/invalid_value_error.rb'

Given("default language is {string}") do |language|
  @directory_path_for_default_language = "../../../../features/test_files/"
	@directory_path_for_default_language = @directory_path_for_default_language + "default_language_" + language.downcase + "/"
  raise_error(TicTacToeRZ::Exceptions::InvalidValueError) if !File.exist?(@directory_path_for_default_language)
  @starting_default_tag = language == "English" ? "en" : "es"
end

When("the user is on the language configuration screen") do
	@language_adapter_with_default_language_selected = TicTacToeRZ::Languages::LanguageOptionsAdapter.new(@directory_path_for_default_language)
	@language_adapter_with_default_language_selected.default_language_tag!(@starting_default_tag)
end

Then("the user is displayed the language choices as {string} and {string}") do |language1, language2|
  choices = @language_adapter_with_default_language_selected.language_descriptions
  expect(choices[0]).to eq(language1)
  expect(choices[1]).to eq(language2)
end

Then("the user is displayed a numeric list of language choices") do
  choices = @language_adapter_with_default_language_selected.input_choices
  expect(choices[0]).to eq("1")
  expect(choices[1]).to eq("2")
end

When("the user selects {string} as a language option") do |string|
  tag = @language_adapter_with_default_language_selected.language_tag_for_description(string)
	@language_adapter_with_default_language_selected.default_language_tag!(tag)
end

Then("the default language is updated to {string}") do |string| 
  actual_tag = @language_adapter_with_default_language_selected.stored_default_tag
	expected_tag = @language_adapter_with_default_language_selected.language_tag_for_description(string)
	expect(actual_tag).to eq(expected_tag)
end
