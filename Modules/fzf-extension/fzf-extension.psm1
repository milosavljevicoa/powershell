function Get-FzfLocation {
    param(
        [Parameter(Mandatory = $false)] [string] $Filter = "",
        [Parameter(Mandatory = $false)] [string] $Path = ".",
        [Parameter(Mandatory = $false)] [int] $Depth = 10,
        [switch] $Directory
    )

    if ($Directory) {
        Get-ChildItem -Recurse -Directory -Path $Path -Filter $Filter -Depth $Depth |
        Select-Object FullName -ExpandProperty FullName |
        fzf --reverse --border 
    } else {
        Get-ChildItem -Recurse -File -Path $Path -Filter $Filter -Depth $Depth |
        Select-Object FullName -ExpandProperty FullName |
        fzf --reverse --border --preview 'bat --style=numbers --color=always {} ' --preview-window down:50%:wrap --bind "ctrl-d:preview-down,ctrl-u:preview-up"
    }
}

function Set-FzfLocation {
    param(
        [Parameter(Mandatory = $false)] [string] $Filter = "",
        [Parameter(Mandatory = $false)] [string] $Path = ".",
        [Parameter(Mandatory = $false)] [int] $Depth = 10
    )

    Get-FzfLocation -Directory -Filter $Filter -Depth $Depth | Set-Location
}

#get cht.sh values Array.from($("#topics").options).map(o => o.value).filter(v => v.includes("topic_to_search"))
$go_entries = "go", "go-bug", "go-build", "go-clean", "go-doc", "go-env", "go-fix", "go-generate", "go-list", "go-mod", "go-test", "go/", "go/:learn", "go/:list", "go/Arrays", "go/Axioms", "go/Channels", "go/Declarations", "go/Embedding", "go/Errors", "go/Interfaces", "go/Maps", "go/Operators", "go/Pointers", "go/Structs", "go/for", "go/func", "go/go", "go/hello", "go/http", "go/if", "go/packages", "go/print", "go/range", "go/rosetta/", "go/slices", "go/switch", "go/types"
$docker_entries = "docker", "docker-build", "docker-compose", "docker-container", "docker-cp", "docker-exec", "docker-image", "docker-images", "docker-inspect", "docker-login", "docker-logs", "docker-machine", "docker-network", "docker-ps", "docker-rmi", "docker-run", "docker-save", "docker-secret", "docker-service", "docker-start", "docker-stats", "docker-swarm", "docker-system", "dockerd", "kdocker", "x11docker"	
$lua_entries = "lua", "lua/", "lua/:learn", "lua/:list", "lua/Class-like_tables", "lua/Comments", "lua/Flow_control", "lua/Functions", "lua/Metatables", "lua/Modules", "lua/Tables", "lua/hello", "lua/rosetta/", "luac", "luarocks" 
$git_entries = "git", "git-add", "git-alias", "git-am", "git-annex", "git-annotate", "git-apply", "git-archive", "git-archive-file", "git-authors", "git-bisect", "git-blame", "git-branch", "git-browse", "git-brv", "git-bugreport", "git-bundle", "git-cat-file", "git-check-attr", "git-check-ignore", "git-check-mailmap", "git-check-ref-format", "git-checkout", "git-checkout-index", "git-cherry", "git-cherry-pick", "git-clean", "git-clone", "git-column", "git-commit", "git-commit-graph", "git-commit-tree", "git-commits-since", "git-config", "git-contrib", "git-count", "git-count-objects", "git-cp", "git-create-branch", "git-credential", "git-daemon", "git-delete-branch", "git-delete-tag", "git-delta", "git-describe", "git-diff", "git-difftool", "git-effort", "git-extras", "git-fame", "git-fetch", "git-flow", "git-for-each-repo", "git-fork", "git-format-patch", "git-fsck", "git-gc", "git-graft", "git-grep", "git-help", "git-ignore", "git-ignore-io", "git-imerge", "git-info", "git-init", "git-instaweb", "git-lfs", "git-local-commits", "git-log", "git-ls-files", "git-ls-remote", "git-ls-tree", "git-mailinfo", "git-maintenance", "git-merge", "git-mergetool", "git-missing", "git-mv", "git-notes", "git-obliterate", "git-pr", "git-prune", "git-pull", "git-push", "git-range-diff", "git-rebase", "git-reflog", "git-release", "git-remote", "git-rename-branch", "git-rename-remote", "git-rename-tag", "git-repack", "git-repl", "git-replace", "git-request-pull", "git-reset", "git-reset-file", "git-restore", "git-rev-list", "git-rev-parse", "git-revert", "git-rm", "git-root", "git-send-email", "git-setup", "git-shortlog", "git-show", "git-show-branch", "git-show-index", "git-show-ref", "git-show-tree", "git-sizer", "git-stage", "git-stash", "git-status", "git-stripspace", "git-submodule", "git-subtree", "git-summary", "git-svn", "git-switch", "git-tag", "git-touch", "git-undo", "git-update-index", "git-update-ref", "git-var", "git-verify-commit", "git-verify-tag", "git-whatchanged", "git-worktree", "git/:learn", "git/:list", "github-label-sync", "gitk", "gitlab", "gitlab-ctl", "gitlab-runner", "gitmoji", "gitsome", "legit"
$python_entries = "ipython", "python", "python/", "python/1_Inheritance", "python/1line", "python/2_Multiple_Inheritance", "python/:learn", "python/:list", "python/Advanced", "python/Classes", "python/Comments", "python/Control_Flow_and_Iterables", "python/Functions", "python/Modules", "python/Primitive_Datatypes_and_Operators", "python/Variables_and_Collections", "python/doc", "python/func", "python/hello", "python/lambda", "python/list_comprehension", "python/loops", "python/recursion", "python/rosetta/", "python3/", "python3/:learn", "python3/:list", "python3/args_kwargs", "python3/classes", "python3/decorator", "python3/generator", "python3/rosetta/", "python3/super", "python3/threads"
$choco_entries = "choco", "choco-apikey", "choco-feature", "choco-info", "choco-install", "choco-list", "choco-new", "choco-outdated", "choco-pack", "choco-pin", "choco-search", "choco-source", "choco-uninstall", "choco-upgrade"
$queries = @{
	go = $go_entries
	docker = $docker_entries
	lua = $lua_entries
	git = $git_entries
	python = $python_entries 
    choco = $choco_entries
}
function Get-ChtSh {
	$sel = $queries.Keys | fzf --reverse --border
	$query = $queries.$sel | fzf --reverse --border
	Invoke-WebRequest -Uri "https://cht.sh/$query" |
        Select-Object -Expand Content
}