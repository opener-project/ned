Feature: Using files as input and output
  In order to perform named entity disambiguation
  Using a file as an input
  Using a file as an output

  Scenario Outline: Perform named entity disambiguation from KAF
    Given the fixture file "<input_file>"
    And I put them through the kernel
    Then the output should match the fixture "<output_file>"
  Examples:
    | input_file   | output_file   |
    | input-de.kaf | output-de.kaf |
    | input-en.kaf | output-en.kaf |
    | input-es.kaf | output-es.kaf |
    | input-fr.kaf | output-fr.kaf |
    | input-it.kaf | output-it.kaf |
    | input-nl.kaf | output-nl.kaf |
