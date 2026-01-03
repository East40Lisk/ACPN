#!/usr/bin/env node
import { Command } from "commander";
import { register } from "./commands/register";
import { addContent } from "./commands/add-content";
import { issueLicense } from "./commands/issue-license";
import { setRule } from "./commands/set-rule";
import { verify } from "./commands/verify";

const program = new Command();

program
  .name("acpn")
  .description("Automated Creator Protection Network CLI")
  .version("0.1.0");

program
  .command("register")
  .description("Register as a new creator")
  .action(register);

program
  .command("add-content")
  .description("Add new content")
  .action(addContent);

program
  .command("issue-license")
  .description("Issue a license for content")
  .action(issueLicense);

program
  .command("set-rule")
  .description("Set an enforcement rule for content")
  .action(setRule);

program
  .command("verify")
  .description("Verify content, license, or enforcement rule")
  .action(verify);

program.parse();
