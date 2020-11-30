start-time = 0
end-time = 1
do-print = $false

fn get-time []{
    put (date +%s%N | cut -b1-13)
}

fn before-hook []{
    end-time = (get-time)
    elapsed = (- $end-time $start-time)
    echo (styled "\t\t"$elapsed" ms" cyan)
}

fn after-hook [line]{
    start-time = (get-time)
}

fn init {
    edit:before-readline = [
        $@edit:before-readline $before-hook~
    ]
    edit:after-readline = [
        $@edit:after-readline $after-hook~
    ]
}

init