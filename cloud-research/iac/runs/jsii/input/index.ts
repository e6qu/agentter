/** A greeting, expressed once in TypeScript and exposed to every jsii target. */
export interface GreeterProps {
  /** Who to greet. */
  readonly name: string;
  /** Optional number of exclamation marks. @default 1 */
  readonly enthusiasm?: number;
}

/** Builds greetings. jsii exposes this class to Python, Java, .NET, Go. */
export class Greeter {
  private readonly name: string;
  private readonly enthusiasm: number;
  public constructor(props: GreeterProps) {
    this.name = props.name;
    this.enthusiasm = props.enthusiasm ?? 1;
  }
  /** Return the greeting string. */
  public greet(): string {
    return `Hello, ${this.name}${'!'.repeat(this.enthusiasm)}`;
  }
}
