--[[

TODO: add regex
{
  -- folders
  ['.Trash'] = ' '
  ['.atom'] = ' ',
  ['.github'] = ' ',
  ['.git'] = ' '
  ['bin'] = ' ',
  ['config'] = ' ',
  ['node_modules'], ' ',

  ['deb'] = ' ',
  ['redis'] = ' ',  -- rdb

  ['dotnet']       = ' ',
  ['extjs']        = ' ',
  ['emberjs']      = ' ',
  ['ionicjs']      = ' ',
  ['laravel']      = ' ',
  ['less']         = ' ',
}
]]

local config = import('micro/config')

local regexp = import('regexp')
local filepath = import('path/filepath')

local ICONS = {
    ['dir'] = ' ',
    ['dir_open'] = ' ',

    ['default'] = ' ',

    ['jenkins'] = ' ',
    ['babel'] = ' ',
    ['yarn'] = ' ',
    ['webpack'] = ' ',
    ['eslint'] = ' ',
    ['graphql'] = ' ',
    ['editorconfig'] = ' ',
    ['vagrant'] = ' ',
    ['fortran'] = '󱈚 ',
    ['jinja'] = ' ',

    ['vscode'] = '󰨞 ',

    ['heroku'] = ' ',
    ['sqlite'] = ' ',

    ['gnu'] = ' ',
    ['log'] = ' ',
    ['kotlin'] = ' ',
    ['makefile'] = ' ',

    ['robots'] = '󰚩 ',
    ['favicon'] = ' ',

    ['ruby'] = ' ',
    ['crystal'] = ' ',

    ['go'] = ' ',
    ['java'] = ' ',
    ['r'] = '󰟔 ',
    ['dart'] = ' ',
    ['hashel'] = ' ',
    ['elixir'] = ' ',
    ['julia'] = ' ',
    ['php'] = ' ',
    ['rust'] = ' ',
    ['prolog'] = ' ',
    ['emacs'] = ' ',
    ['lua'] = ' ',
    ['elm'] = ' ',
    ['sql'] = ' ',
    ['zig'] = ' ',
    ['d'] = ' ',
    ['erlang'] = ' ',
    ['coffee'] = ' ',
    ['swift'] = ' ',
    ['h'] = ' ',
    ['clojure'] = ' ',
    ['scala'] = ' ',
    ['cobol'] = '⚙ ',
    ['f#'] = ' ',
    ['groovy'] = ' ',
    ['python'] = ' ',
    ['xml'] = '󰗀 ',
    ['sh'] = ' ',
    ['powershell'] = ' ',
    ['tex'] = ' ',
    ['markdown'] = ' ',

    ['sass'] = ' ',
    ['css'] = ' ',
    ['html'] = ' ',
    ['javascript'] = ' ',
    ['typescript'] = '󰛦 ',
    ['vue'] = '󰡄 ',
    ['bower'] = ' ',
    ['mustache'] = ' ',
    ['nodemon'] = ' ',
    ['npm'] = ' ',
    ['grunt'] = ' ',
    ['nodejs'] = '󰎙 ',
    ['jquery'] = '󰡽 ',
    ['require'] = ' ',
    ['angular'] = ' ',
    ['react'] = ' ',
    ['mootools'] = ' ',
    ['backbone'] = ' ',
    ['gulp'] = ' ',
    ['materialize'] = ' ',
    ['json'] = '󰘦 ',
    ['svelte'] = ' ',

    ['travis'] = ' ',
    ['gitlab'] = ' ',

    ['brackets'] = ' ',
    ['docker'] = '󰡨 ',
    ['license'] = ' ',
    ['git'] = ' ',
    ['tag'] = ' ',
    ['lock'] = '󰌾 ',
    ['settings'] = ' ',
    ['compact'] = ' ',
    ['key'] = ' ',
    ['mail'] = ' ',
    ['todo'] = ' ',
    ['vim'] = ' ',
    ['lambda'] = '󰘧 ',
    ['onion'] = ' ',

    ['c'] = '󰙱 ',
    ['c#'] = ' ',
    ['c++'] = '󰙲 ',

    ['ai'] = ' ',

    ['windows'] = ' ',
    ['word'] = '󱎒 ',
    ['powerpoint'] = '󱎐 ',
    ['excel'] = '󱎏 ',

    -- ['toml'] = '[T] ',
    ['toml'] = '󰰤 ',
    ['terraform'] = ' ',

    ['nix'] = ' ',
    ['firefox'] = ' ',
    ['rss'] = '󰑫 ',
    ['iso'] = ' ',

    ['csv'] = ' ',
    ['txt'] = ' ',
    ['pdf'] = ' ',
    ['mp3'] = ' ',
    ['video'] = ' ',
    ['image'] = ' ',
    ['dump'] = ' ',

    ['haml'] = ' ',
    ['diff'] = ' ',
    ['twig'] = ' ',
    ['puppet'] = ' ',

    ['styl'] = ' ',
    ['yaml'] = ' ',
    ['import'] = ' ',
    ['rpm'] = ' ',
    ['font'] = ' ',
    ['desktop'] = ' ',
    ['mkdocs'] = ' ',
    ['epub'] = ' ',
}

local PATTERNS = {
    --# Exact
    ['^Bis[Oo]n$'] = ICONS['GNU'],
    ['^Procfile$'] = ICONS['heroku'],
    ['^sqliterc$'] = ICONS['sqlite'],
    ['^mix.lock$'] = ICONS['elixir'],
    ['^[Jj]ulia$'] = ICONS['julia'],
    ['^log\\.txt$'] = ICONS['log'],
    ['mkdocs\\.ya?ml'] = ICONS['mkdocs'],
    ['^k[Oo]tlin$'] = ICONS['kotlin'],
    ['^\\.npm(ignore|rc)$'] = ICONS['npm'],
    ['^[Mm]akefile'] = ICONS['makefile'],
    ['^config\\.ru$'] = ICONS['ruby'],
    ['^bower\\.json'] = ICONS['bower'],
    ['^Jenkinsfile$'] = ICONS['jenkins'],
    ['^robots\\.txt$'] = ICONS['robots'],
    ['^Cargo\\.lock$'] = ICONS['rust'],
    ['^mustache\\.js$'] = ICONS['mustache'],
    ['^favicon\\.ico$'] = ICONS['favicon'],
    ['^\\.editorconfig$'] = ICONS['editorconfig'],
    ['^nodemon\\.json$'] = ICONS['nodemon'],
    ['^go\\.(mod|sum)$'] = ICONS['go'],
    ['^(APK|PKG)BUILD$)'] = ICONS['sh'],
    ['^composer\\.json$'] = ICONS['php'],
    ['^\\.npm(ignore|rc)'] = ICONS['npm'],
    ['\\.settings\\.json'] = ICONS['vscode'],
    ['^\\.travis\\.ya?ml$'] = ICONS['travis'],
    ['^gruntfile\\.([jl]s|coffee)$'] = ICONS['grunt'],
    ['^\\.brackets\\.json'] = ICONS['brackets'],
    ['^cargo\\.(toml|lock)$'] = ICONS['rust'],
    ['^\\.gitlab-ci\\.ya?ml$'] = ICONS['gitlab'],
    ['^package(-lock)?\\.json$'] = ICONS['nodejs'],
    ['^gulpfile\\.([jl]s|coffee)$'] = ICONS['gulp'],
    ['^(Dockerfile|\\.dockerignore)$'] = ICONS['docker'],
    ['^(Pkgfile|(pkgmk|rc)\\.conf$)$'] = ICONS['sh'],
    ['^(LICENSE|COPYING(\\.LESSER)?)$'] = ICONS['license'],
    ['^docker-compose(\\..*)?\\.ya?ml$'] = ICONS['docker'],
    ['^npm-(debug\\.log|shrinkwrap\\.json)$'] = ICONS['npm'],
    ['^\\.git(config|modules|ignore|attributes)$'] = ICONS['git'],
    ['^(MERGE_MSG|git-rebase-todo|(COMMIT|TAG)_EDITMSG)$'] = ICONS['git'],
    ['^\\.(vbnet|((vs)?settings|vscodeignore)\\.json|vscode)$'] = ICONS['vscode'],
    ['^\\.bash_(aliases|functions|profile|history|logout)$'] = ICONS['sh'],
    ['^(Gem|Rake|Cap|Guard|App|Fast|Pod|Plugin|\\.?[Bb]rew)file)$'] = ICONS['ruby'],

    --# Glob
    ['LOG'] = ICONS['log'],
    ['TAGS'] = ICONS['tag'],
    ['LOCK'] = ICONS['lock'],
    ['\\.env'] = ICONS['settings'],
    ['\\.tar'] = ICONS['compact'],
    ['id_rsa'] = ICONS['key'],
    ['\\..+rc$'] = ICONS['settings'],
    ['mutt-.*$'] = ICONS['mail'],
    ['(todo|TODO)'] = ICONS['todo'],
    ['.*jquery.*\\.js$'] = ICONS['jquery'],
    ['.*require.*\\.js$'] = ICONS['require'],
    ['.*angular.*\\.js$'] = ICONS['angular'],
    ['.*mootools.*\\.js$'] = ICONS['mootools'],
    ['.*backbone.*\\.js$'] = ICONS['backbone'],
    ['(swipl|Pr[Oo]l[Oo]g|yap)$'] = ICONS['prolog'],
    ['([_\\.]g?vimrc$|.*vimrc.*)'] = ICONS['vim'],
    ['.*materialize.*\\.(css|js)$'] = ICONS['materialize'],
    ['guile|bigloo|chicken|Scheme$'] = ICONS['lambda'],
    ['webpack\\.config\\.(babel\\.js|(coffee|[jt]s))$'] = ICONS['webpack'],
    ['tsconfig-for-webpack-config\\.json$'] = ICONS['webpack'],
    ['\\.babelrc(\\.(json|([cm]?j)s|cts)?'] = ICONS['babel'],
    ['babel\\.config\\.(json|([cm]?j)s|cts)'] = ICONS['babel'],
    ['(yarn\\.lock|\\.yarnrc)$'] = ICONS['yarn'],
    ['\\.eslintrc\\.(c?js|ya?ml|json)$'] = ICONS['eslint'],

    --# Extensions
    ['\\.t$'] = ICONS['onion'],
    ['\\.cs$'] = ICONS['c#'],
    ['\\.cr$'] = ICONS['crystal'],
    ['\\.ts$'] = ICONS['typescript'],
    ['\\.ai$'] = ICONS['ai'],
    ['\\.el$'] = ICONS['emacs'],
    ['\\.tf$'] = ICONS['terraform'],
    ['\\.lua$'] = ICONS['lua'],
    ['\\.elm$'] = ICONS['elm'],
    ['\\.log$'] = ICONS['log '],
    ['\\.eml$'] = ICONS['mail'],
    ['\\.sql$'] = ICONS['sql'],
    ['\\.vue$'] = ICONS['vue'],
    ['\\.sml$'] = ICONS['lambda'],
    ['\\.exe$'] = ICONS['windowns'],
    ['\\.nix$'] = ICONS['nix'],
    ['\\.pdf$'] = ICONS['pdf'],
    ['\\.mp3$'] = ICONS['mp3'],
    ['\\.zig$'] = ICONS['zig'],
    ['\\.xul$'] = ICONS['firefox'],
    ['\\.rss$'] = ICONS['rss'],
    ['\\.iso$'] = ICONS['iso'],
    ['\\.csv$'] = ICONS['csv'],
    ['\\.txt$'] = ICONS['text'],
    ['\\.gif$'] = ICONS['image'],
    ['\\.zip$'] = ICONS['compact'],
    ['\\.doc$'] = ICONS['word'],
    ['\\.ppt$'] = ICONS['powerpoint'],
    ['\\.mp4$'] = ICONS['video '],
    ['\\.epub$'] = ICONS['epub'],
    ['\\.ma?k$'] = ICONS['makefile'],
    ['\\.toml$'] = ICONS['toml'],
    ['\\.webp$'] = ICONS['image'],
    ['\\.dump$'] = ICONS['dump'],
    ['\\.haml$'] = ICONS['haml'],
    ['\\.diff$'] = ICONS['diff'],
    ['\\.twig$'] = ICONS['twig'],
    ['\\.e?pp$'] = ICONS['puppet'],
    ['\\.java$'] = ICONS['java'],
    ['\\.[rR]$'] = ICONS['r'],
    ['\\.dart$'] = ICONS['dart'],
    ['\\.l?hs$'] = ICONS['hashel'],
    ['\\.mli?$'] = ICONS['lambda'],
    ['\\.json$'] = ICONS['json'],
    ['\\.styl$'] = ICONS['styl'],
    ['\\.exs?$'] = ICONS['elixir'],
    ['\\.lock$'] = ICONS['lock'],
    ['\\.ya?ml$'] = ICONS['yaml'],
    ['\\.(jinja|j)2$'] = ICONS['jinja'],
    ['\\.patch$'] = ICONS['diff'],
    ['\\.swift$'] = ICONS['swift'],
    ['\\.svelte$'] = ICONS['svelte'],
    ['\\.coffee$'] = ICONS['coffee'],
    ['\\.[jt]sx$'] = ICONS['react'],
    ['\\.d[id]?$'] = ICONS['d'],
    ['\\.[eh]rl$'] = ICONS['erlang'],
    ['\\.p[lmp]$'] = ICONS['onion'],
    ['\\.import$'] = ICONS['import'],
    ['\\.s[ac]ss$'] = ICONS['sass'],
    ['\\.t(cl|bc)$'] = ICONS['onion'],
    ['\\.s(uo|ln)$'] = ICONS['vscode'],
    ['\\.xls[xmb]?$'] = ICONS['excel'],
    ['\\.(key|pem)$'] = ICONS['key'],
    ['\\.j(l|ulia)$'] = ICONS['julia'],
    ['\\.db-journal$'] = ICONS['sql'],
    ['\\.html?[45]?$'] = ICONS['html'],
    ['\\.(css|less)$'] = ICONS['css'],
    ['\\.(rpm)?spec$'] = ICONS['rpm'],
    ['\\.(ba|z)shrc$'] = ICONS['sh'],
    ['\\.(tt[cf]|otf)'] = ICONS['font'],
    ['\\.ps(1|m1|d1)$'] = ICONS['powershell'],
    ['\\.h(h|pp|xx)?$'] = ICONS['h'],
    ['\\.go(doc|lo)?$'] = ICONS['go'],
    ['\\.xcplayground$'] = ICONS['swift'],
    ['\\.(pc|desktop)$'] = ICONS['desktop'],
    ['\\.php[2345s~]?$'] = ICONS['php'],
    ['\\.(gql|graphql)$'] = ICONS['graphql'],
    ['\\.(tex|bib|cls)$'] = ICONS['tex'],
    ['\\.(db|sqlite3?)$'] = ICONS['sqlite'],
    ['\\.(clj[sc]?|edn)$'] = ICONS['clojure'],
    ['\\.(sc(ala)?|sbt)$'] = ICONS['scala'],
    ['\\.(pro(log)?|yap)$'] = ICONS['prolog'],
    ['\\.(m?js|es[5678]?)$'] = ICONS['javascript'],
    ['\\.c(bl|py|ob(ol)?)$'] = ICONS['cobol'],
    ['\\.((ex|vim)rc|vim)$'] = ICONS['vim'],
    ['\\.([cChH]|ii?|def)$'] = ICONS['c'],
    ['\\.(ebuild|profile)$'] = ICONS['sh'],
    ['\\.(kt[sm]?|kotlin)$'] = ICONS['kotlin'],
    ['\\.(a|c|k|z|ba|fi)?sh$'] = ICONS['sh'],
    ['\\.(jpg|png|jpeg|icon)$'] = ICONS['image'],
    ['\\.(?:vba?|fr[mx]|bas)$'] = ICONS['vscode'],
    ['\\.(rb|rake|gemspec|rvm)$'] = ICONS['ruby'],
    ['\\.f(#|s[ix]?|sscript)?$'] = ICONS['f#'],
    ['\\.(scm|scheme|sld|sps)$'] = ICONS['lambda'],
    ['\\.g(roovy|v?y|sh|radle)$'] = ICONS['groovy'],
    ['\\.(py[23cdioxw]?|ipynb)$'] = ICONS['python'],
    ['\\.(bison|(?:gnu|gplv[23]))$'] = ICONS['gnu'],
    ['\\.([Ff](9[05]|[Oo])?|[Rr])$'] = ICONS['fortran'],
    ['\\.(xml|sgml?|rng|svg|plist)$'] = ICONS['xml'],
    ['\\.z(shenv|profile|login|logout)$'] = ICONS['sh'],
    ['\\.(rs(lib)?|cargo|release\\.toml)$'] = ICONS['rust'],
    ['\\.(c(c|pp|xx)|h(h|pp|xx)|ii?|def)$'] = ICONS['c++'],
    ['\\.(vbs|vsix|csproj|vbproj|vcx?proj)$'] = ICONS['vscode'],
    ['\\.((live)?mk?d|mkdn|rmd|markdown|mdx)$'] = ICONS['markdown'],
    ['\\.(vstemplate|vsixmanifest|builds|sln|njsproj)$'] = ICONS['vscode'],
    ['\\.(ini|lfl|override|tscn|tres|config|conf|cson)$'] = ICONS['settings'],
}

local FALLBACK = {
    ['dir'] = '+ ',
    ['dir_open'] = '- ',
    ['default'] = '',
}

local function Icons()
    local nerdfonts = config.GetGlobalOption('filemanager2.nerdfonts')

    if nerdfonts then
        return ICONS
    end

    return FALLBACK
end

local function GetIcon(path)
    local nerdfonts = config.GetGlobalOption('filemanager2.nerdfonts')
    if not nerdfonts then
        return FALLBACK['default']
    end

    local _, filename = filepath.Split(path)
    for pattern, icon in pairs(PATTERNS) do
        if regexp.MatchString(pattern, filename) then
            return icon
        end
    end

    return ICONS['default']
end

return { Icons = Icons, GetIcon = GetIcon }
