runtime! plugin/tabpagecd.vim

describe 'Basics'
  before
    let g:cwd = getcwd()
  end

  after
    cd `=fnameescape(g:cwd)`
  end

  it 'should record/change the current working directory for each tab page'
    Expect exists('t:cwd') toBeFalse

    let t:id = 1
    cd ./t
    tabnew
    let t:id = 2
    cd ../plugin

    tabnext 1
    Expect t:id == 1
    Expect t:cwd ==# g:cwd . '/t'
    Expect getcwd() ==# t:cwd

    tabnext 2
    Expect t:id == 2
    Expect t:cwd ==# g:cwd . '/plugin'
    Expect getcwd() ==# t:cwd
  end
end
