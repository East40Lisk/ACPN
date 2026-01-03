import inquirer from "inquirer";
import fs from "fs-extra";
import { v4 as uuidv4 } from "uuid";
import chalk from "chalk";

export async function issueLicense() {
  const answers = await inquirer.prompt([
    { type: "input", name: "contentId", message: "Content ID:" },
    { type: "input", name: "recipient", message: "Issued To (user/app):" },
    { type: "list", name: "type", message: "License Type:", choices: ["exclusive","non-exclusive","open-source","personal-use","custom"] }
  ]);

  const license = {
    id: uuidv4(),
    type: answers.type,
    issuedTo: answers.recipient,
    issuedAt: new Date().toISOString(),
    conditions: {}
  };

  const filePath = `./acpn-data/content-${answers.contentId}.json`;
  const content = await fs.readJson(filePath);
  content.licenses.push(license);
  await fs.writeJson(filePath, content, { spaces: 2 });

  console.log(chalk.green("✅ License issued!"));
  console.log(chalk.blue("License ID:"), license.id);
}
