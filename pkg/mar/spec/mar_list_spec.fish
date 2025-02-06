function describe_mar_list_tests
  function before_all
    set -gx CI WORKAROUND
  end

  function it_can_list_plugins
    set -l list_output (mar list -p)
    assert 0 = $status
    assert "$list_output" = "fish-spec	mar"
  end

  function it_can_list_themes
    set -l list_output (mar list -t)
    assert 0 = $status
    assert "$list_output" = "default"
  end

  function it_can_list_insttalled_plugins
    set -l output (mar remove apt 2> /dev/null)
    set -l output (mar install apt 2> /dev/null)
    set -l list_output (mar list -p)
    assert 0 = $status
    assert "$list_output" = "apt		fish-spec	mar"
    set -l output (mar remove apt 2> /dev/null)
  end

  function it_can_list_themes
    set -l list_output (mar list -t)
    assert 0 = $status
    assert "$list_output" = "default"
  end
end
