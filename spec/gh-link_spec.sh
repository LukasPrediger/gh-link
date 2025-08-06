Describe 'gh-link' # example group
  testdir=".temptestdir"
  setup() { mkdir $testdir; }
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
    The stderr should eq "File 'non-existing-file.md' does not exist."
  End

  It 'fails for an untracked file'
  touch "${testdir}/untracked-file.md"
  When run script gh-link "${testdir}/untracked-file.md"
    The status should be failure
    The stderr should eq "File '${testdir}/untracked-file.md' is not tracked by git."
  End
End