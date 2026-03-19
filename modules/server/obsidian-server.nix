{ pkgs, username, ... }:
let

  dir = "/home/${username}/Documents/Obsidian";
  tasks_file = "Tarefas.md";
  tomorrow_tasks_file = "Tarefas de Amanhã.md";

in
{
  systemd = {
    services.obsidian-updater = {
      description = "Automation enhancer on my personal Obsidian setup.";
      after = [ ];
      serviceConfig = {
        type = "oneshot";
        ExecStart = pkgs.writeShellScript "obsidian-updater" ''
          #!/bin/bash

          cd ${dir}

          yesterday_date = $(date -d "-1 day" +%Y%m%d)

          if [ -f ${tasks_file} ]; then
             mv ${tasks_file} ./.history/tasks/tasks_"$yesterday_date".md
          else
             generate_task_file(${tasks_file})
          fi

          if [ -f "${tomorrow_tasks_file}" ]; then
             mv ${tomorrow_tasks_file} ${tasks_file}
             generate_tasks_file(${tomorrow_tasks_file})
          fi

          generate_task_file() {

          local file = $1

          cat > "$1" << 'EOF'
          Tarefas Primárias
          - [ ]
          - [ ]
          - [ ]

          Tarefas Secundárias
          - [ ]
          - [ ]
          - [ ]
          - [ ]
          - [ ]
          EOF

          }

        '';
        User = "root";
      };
    };
    timers.obsidian-updater = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 12:00:00";
        Persistant = true;
      };
    };
  };
}
