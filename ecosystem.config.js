module.exports = {
    apps: [
      {
        name: "celery-worker-1",
        script:
          "$(poetry env info -p)/bin/python3 -m celery -A app worker --concurrency=5 -l info --hostname=sample_worker_host@%h&",
      },
    ],
    deploy: {
      production_1: {
        user: "ec2-user",
        host: "52.54.155.141",
        ref: "origin/main",
        repo: "git@github.com:sohum-edra/my_celery_app.git",
        path: "/home/app/my_celery_app",
        key: "~/Downloads/test-worker-1.pem",
        ssh_options: ["ForwardAgent=yes"],
        "post-deploy":
          "cd /home/app/my_celery_app/current && poetry install && cp ~/.private/.env ~/my_celery_app/current && pm2 reload ecosystem.config.js --only celery-worker-1",
        "post-setup":
          "python3 -m pip install --user pipx && python3 -m pipx ensurepath && pipx install poetry==1.7.1 && cd /home/app/my_celery_app/current/ && poetry install",
      }
    },
  };
  