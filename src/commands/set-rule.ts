import inquirer from "inquirer";
import fs from "fs-extra";
import { v4 as uuidv4 } from "uuid";
import chalk from "chalk";

export async function setRule() {
  const answers = await inquirer.prompt([
    { type: "input", name: "contentId", message: "Content ID:" },
    { type: "list", name: "ruleType", message: "Rule Type:", choices: ["revocation", "permission", "notification", "quorum-approval"] },
    { type: "list", name: "action", message: "Action:", choices: ["revoke","notify","block","require-quorum"] }
  ]);

  const rule = {
    id: uuidv4(),
    contentId: answers.contentId,
    ruleType: answers.ruleType,
    action: answers.action,
    conditions: {},
    executedAt: null
  };

  const filePath = `./acpn-data/rules.json`;
  const rules = await fs.pathExists(filePath) ? await fs.readJson(filePath) : [];
  rules.push(rule);
  await fs.writeJson(filePath, rules, { spaces: 2 });

  console.log(chalk.green("✅ Enforcement rule added!"));
  console.log(chalk.blue("Rule ID:"), rule.id);
}
