{ pkgs, username, ... }:
let

  dir = "/home/${username}/Documents/Obsidian";
  tasks_file = "Tarefas.md";
  tomorrow_tasks_file = "Tarefas de Amanhã.md";

  tasks_file_content = ''
    Tarefas Primárias
    - [ ] :
    - [ ] :
    - [ ] :

    Tarefas Secundárias
    - [ ] :
    - [ ] :
    - [ ] :
    - [ ] :
    - [ ] :
  '';

in
{
  systemd = {
    services.obsidian-updater = {
      description = "Automation enhancer on my personal Obsidian setup.";
      after = [ ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "obsidian-updater" ''
          #!/bin/bash

          dir="${dir}"
          tasks_file="${tasks_file}"
          tomorrow_tasks_file="${tomorrow_tasks_file}"
          tasks_file_content="${tasks_file_content}";

          generate_tasks_file() {
          cat > "$1" << EOF
          $tasks_file_content
          EOF
          }

          cd "$dir"

          date_yesterday=$(date -d "-1 day" +%Y-%m-%d)

          systemctl stop syncthing

          if [ -f "$tasks_file" ]; then
             mv "$tasks_file" ./.history/tasks/tasks_"$date_yesterday".md
          fi

          if [ -f "$tomorrow_tasks_file" ]; then
             mv "$tomorrow_tasks_file" "$tasks_file"
          fi

          if [ ! -f "$tasks_file" ]; then
             generate_tasks_file "$tasks_file"
          fi

          if [ ! -f "$tomorrow_tasks_file" ]; then
             generate_tasks_file "$tomorrow_tasks_file"
          fi

          systemctl start syncthing

        '';
        User = "root";
      };
    };
    timers.obsidian-updater = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 00:00:00";
        Persistant = true;
      };
    };
  };
}
