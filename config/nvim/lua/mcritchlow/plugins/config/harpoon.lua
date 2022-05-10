local ok, harpoon = pcall(require, "harpoon")

if not ok then
    return
end

harpoon.setup({
    global_settings = {
        enter_on_sendcmd = true
    },
    projects = {
        ["$HOME/projects/ucsd/surfliner/tidewater"] = {
            term = {
                cmds = {
                    "docker-compose build && docker-compose up",
                    "docker-compose down -v",
                    "docker-compose exec web bin/tidewater_consumer"
                }
            }
        },
        ["$HOME/projects/ucsd/surfliner/comet"] = {
            term = {
                cmds = {
                    "docker-compose build && docker-compose up",
                    "docker-compose down -v"
                }
            }
        },
        ["$HOME/projects/ucsd/surfliner/shoreline/discovery"] = {
            term = {
                cmds = {
                    "docker-compose build && docker-compose up",
                    "docker-compose down -v"
                }
            }
        },
        ["$HOME/projects/ucsd/surfliner/starlight"] = {
            term = {
                cmds = {
                    "docker-compose build && docker-compose up",
                    "docker-compose down -v"
                }
            }
        },
        ["$HOME/projects/ucsd/surfliner/superskunk"] = {
            term = {
                cmds = {
                    "docker-compose build && docker-compose up",
                    "docker-compose down -v"
                }
            }
        },
        ["$HOME/projects/ucsd/alma-apbatch"] = {
            term = {
                cmds = {
                    "docker-compose build && docker-compose up",
                    "docker-compose down -v"
                }
            }
        },
        ["$HOME/projects/ucsd/highfive"] = {
            term = {
                cmds = {
                    "docker-compose build && docker-compose up",
                    "docker-compose down -v"
                }
            }
        },
    }
})
