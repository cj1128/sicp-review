# Generate code to draw the graph of count-change
# using GraphViz
coins = [50, 25, 10, 5, 1]

# return (node string, label string)
def get_str(level, amount, kind):
  return (f"[{level}] (cc {amount} {kind})", f"(cc {amount} {kind})")

def is_leaf(amount, kind):
  return amount <= 0 or kind == 0

def cc(level, amount, kind):
  (ns, ls) = get_str(level, amount, kind)

  if level == 0:
    print(f'  "{ns}" [label = "{ls}"];')

  if amount < 0:
    return 0
  if kind == 0:
    return 0
  if amount == 0:
    return 1

  left_amount = amount
  left_kind = kind - 1
  left_is_leaf = is_leaf(left_amount, left_kind)
  (left_ns, left_ls) = get_str(level+1, left_amount, left_kind)
  print(f'  "{ns}" -> "{left_ns}"; "{left_ns}" [label="{left_ls}", {"color=gray85" if left_is_leaf else ""}];')
  left = cc(level+1, left_amount, left_kind)

  right_amount = amount - coins[5-kind]
  right_kind = kind
  right_is_leaf = is_leaf(right_amount, right_kind)
  (right_ns, right_ls) = get_str(level+1, right_amount, right_kind)
  print(f'  "{ns}" -> "{right_ns}"; "{right_ns}" [label="{right_ls}", {"color=gray85" if right_is_leaf else ""}];')
  right = cc(level+1, right_amount, right_kind)

  return left + right

def run():
  print("""digraph G {
  node [color=gray95, style=filled];
  graph [ranksep=0.25];
  node [color=gray95, style=filled, fontsize=9, shape=box, margin=.08, width=0, height=0 ];
  edge [penwidth=.5, arrowsize=0.5];
""")

  cc(0, 11, 5)

  print("}")

run()
