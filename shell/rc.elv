edit:prompt = {
	(constantly (styled "::: " fg-green)); (constantly (styled (whoami)@(hostname)));
	(constantly (styled " ::: " fg-green)); tilde-abbr $pwd;
	(constantly (styled " :::\n " fg-green)); put "λ "
}

edit:rprompt = {
	put ''
}

fn ls [@a]{ e:exa $@a }
fn lsr [@a]{ e:exa --tree --level=3 $@a }
fn ll [@a]{ e:exa -l $@a }
