# Basic functions in MMA12

# Dot & Outer

# TrigToExp

# Simplify

Q:提示：Simplify::time: Time spent on a transformation exceeded 300.` seconds, and the transformation was aborted. Increasing the value of TimeConstraint option may improve the result of simplification. 但是给出了化简结果，这个化简结果对吗？

Gemini:这个化简结果在数学上是正确的，但它并不是“最终、最简”的结果。Mathematica 的化简机制是树状搜索。在执行 Simplify 或 FullSimplify 时，它会尝试成百上千种不同的代数恒等变换（如提取公因式、三角函数展开、特殊函数转化等）。当 300 秒超时发生时，Mathematica 只是终止了继续寻找更优解的尝试。它丢弃了当前正在计算、进行到一半的那个复杂变换分支（这就是 transformation was aborted 的含义）。然后，它会把截至超时那一刻，系统已经找到的、得分最高（表达式最精简）的那个中间结果返回给你。因为这个中间结果是由一系列已经完成的、合法的数学恒等变形得来的，所以它的正确性没有问题，你可以放心使用。
