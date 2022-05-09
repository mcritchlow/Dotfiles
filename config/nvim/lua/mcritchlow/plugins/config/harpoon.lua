local ok, harpoon = pcall(require, "harpoon")

if not ok then
    return
end

harpoon.setup({
    projects = {
        ["$HOME/projects/ucsd/surfliner/tidewater"] = {
            term = {
                cmds = {
                    "docker-compose build && docker-compose up\n",
                    "docker-compose down -v\n",
                    "docker-compose exec web bin/tidewater_consumer\n"
                }
            }
        },
        ["$HOME/projects/ucsd/surfliner/comet"] = {
            term = {
                cmds = {
                    "docker-compose build && docker-compose up\n",
                    "docker-compose down -v\n"
                }
            }
        },
        ["$HOME/projects/ucsd/surfliner/shoreline/discovery"] = {
            term = {
                cmds = {
                    "docker-compose build && docker-compose up\n",
                    "docker-compose down -v\n"
                }
            }
        },
        ["$HOME/projects/ucsd/surfliner/starlight"] = {
            term = {
                cmds = {
                    "docker-compose build && docker-compose up\n",
                    "docker-compose down -v\n"
                }
            }
        },
        ["$HOME/projects/ucsd/surfliner/superskunk"] = {
            term = {
                cmds = {
                    "docker-compose build && docker-compose up\n",
                    "docker-compose down -v\n"
                }
            }
        },
        ["$HOME/projects/ucsd/alma-apbatch"] = {
            term = {
                cmds = {
                    "docker-compose build && docker-compose up\n",
                    "docker-compose down -v\n"
                }
            }
        },
    }
})
