library tldr.src.page;

class Page {
  final String name;
  final List<String> description;
  final List<Example> examples;

  const Page(this.name, this.description, this.examples);
}

class Example {
  final String description;
  final String command;

  const Example(this.description, this.command);
}
