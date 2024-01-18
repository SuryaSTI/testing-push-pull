FROM mariadb:10.11.6

CMD ["--character-set-server=utf8mb4", "--collation-server=utf8mb4_general_ci", "--max-allowed-packet=2000M"]
