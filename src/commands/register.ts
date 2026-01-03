import inquirer from "inquirer";
import fs from "fs-extra";
import { v4 as uuidv4 } from "uuid";
import chalk from "chalk";

export async function register() {
  const answers = await inquirer.prompt([
    { type: "input", name: "name", message: "Creator Name:" },
    { type: "input", name: "email", message: "Email (optional):" }
  ]);

  const creator = {
    id: uuidv4(),
    name: answers.name,
    email: answers.email || null,
    publicKey: "TODO_GENERATE_KEY",
    registeredAt: new Date().toISOString()
  };

  await fs.ensureDir("./acpn-data");
  const filePath = `./acpn-data/creator-${creator.id}.json`;
  await fs.writeJson(filePath, creator, { spaces: 2 });

  console.log(chalk.green("✅ Creator registered!"));
  console.log(chalk.blue("ID:"), creator.id);
}
