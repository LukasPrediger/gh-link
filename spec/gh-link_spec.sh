Describe 'gh-link' # example group
  testdir=".temptestdir"
  setup() { mkdir -p $testdir; }
  cleanup() { rm -r $testdir; }
  Before 'setup'
  After 'cleanup'
  It 'create link to readme file'
    When run script gh-link README.md
    The output should eq "https://github.com/LukasPrediger/gh-link/blob/main/README.md"
  End

  It 'creates static link to readme file'
      rev=$(git rev-parse HEAD)
      When run script gh-link -s README.md
      The output should eq "https://github.com/LukasPrediger/gh-link/blob/$rev/README.md"
  End

  It 'returns error if the file does not exist'
    When run script gh-link non-existing-file.md
    The status should be failure
    The error should eq "File 'non-existing-file.md' does not exist."
  End

  It 'fails for an untracked file'
    touch "${testdir}/untracked-file.md"
    When run script gh-link "${testdir}/untracked-file.md"
      The status should be failure
      The error should eq "File '${testdir}/untracked-file.md' is not tracked by git."
  End

  Describe 'with -l'
    Pending "not yet implemented"
    It 'creates link to a single line'
      When run script gh-link README.md -l 1
        The output should eq "https://github.com/LukasPrediger/gh-link/blob/main/README.md#L1"
    End

    It 'creates link to a range of lines'
      When run script gh-link README.md -l 1:3
        The output should eq "https://github.com/LukasPrediger/gh-link/blob/main/README.md#L1-L3"
    End

    It 'creates link to a right open range of lines'
      linecount=$(grep -c "" README.md)
      When run script gh-link README.md -l 1:
        The output should eq "https://github.com/LukasPrediger/gh-link/blob/main/README.md#L1-L$linecount"
    End

    It 'creates link to a left open range of lines'
      When run script gh-link README.md -l :5
        The output should eq "https://github.com/LukasPrediger/gh-link/blob/main/README.md#L1-L5"
    End

    It 'returns an error if the line range is out of range'
      When run script gh-link README.md -l 99999
        The status should be failure
        The error should eq "Invalid Line Range: 99999 is out of range for file README.md."
    End

    It 'returns an error if the line number is 0'
      When run script gh-link -l 0 README.md
        The status should be failure
        The error should eq "Invalid Line Range: 0 is not a valid range."
    End

    It 'returns an error if no line range is specified'
      When run script gh-link README.md -l
        The status should be failure
        The error should eq "-l expects a parameter, but none was given."
    End

    It 'creates link to a single line for multiple files'
      When run script gh-link -l 1 README.md gh-link
        The line 1 should eq "https://github.com/LukasPrediger/gh-link/blob/main/README.md#L1"
        The line 2 should eq "https://github.com/LukasPrediger/gh-link/blob/main/gh-link#L1"
    End

    It 'creates static link to a line in the readme file'
        rev=$(git rev-parse HEAD)
        When run script gh-link -s -l 1 README.md
          The output should eq "https://github.com/LukasPrediger/gh-link/blob/$rev/README.md#L1"
    End

  End
End