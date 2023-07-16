{ pkgs, ... }:

{
  env.PC_TUI_ENABLED = "false";

  packages = [
    pkgs.git
    pkgs.nodejs_18
  ];

  services.postgres = {
    enable = true;
    package = pkgs.postgresql_13;
    port = 6500;
    listen_addresses = "127.0.0.1";
    initialDatabases = [
      { name = "postgres"; }
    ];
    initialScript = ''
      CREATE USER postgres SUPERUSER;
    '';
  };

  process.implementation = "process-compose";
  processes = {
    dev = {
      exec = "npm run dev";
    };
  };
}
