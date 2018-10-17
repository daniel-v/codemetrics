workflow "Test" {
  on = "EVENT"
  resolves = "action test"
}

action "action test" {
  uses = "./action-test/"
}
