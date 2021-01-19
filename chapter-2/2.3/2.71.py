import sys

# generate dot files for n symbols
def run(n):
  print("""digraph {
  node [shape=plaintext]
""")

  for i in range(n-1):
    node = "r" + str(i)
    next_node = "r" + str(i + 1)
    value = 2 ** (n - 1 - i)

    if i == n - 2:
      next_node = 1

    print(f'  {node}[label="•"]')
    print(f"  {node} -> {value}")
    print(f"  {node} -> {next_node}")
    print()

  print("}")

run(int(sys.argv[1]))
