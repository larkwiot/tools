use ./time
use ./cd

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
fn cat [@a]{ e:batcat $@a }
fn fd [@a]{ e:fdfind $@a }
fn vim [@a]{ e:micro $@a }

fn dc [@a]{ e:docker-compose $@a }
fn dcupd [@a]{ e:docker-compose up -d $@a }
fn dcrestart [@a]{ e:docker-compose restart $@a }
fn dcdn [@a]{ e:docker-compose down $@a }
fn dclogs [@a]{ e:docker-compose logs $@a }

fn ugly [@a]{ e:ug -nrIQZ -e "" . }

fn bat [@a]{ e:batcat $@a }
