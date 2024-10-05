# Department of Electrical Engineering
MINI PROJECT
Design and Testing of Pipelined and Unpipelined MAC Unit
________________________________________

Introduction
This project aimed to design, implement, and test a Multiply-Accumulate (MAC) unit for half-precision floating-point numbers based on the IEEE 754 standard. The half-precision format, which is 16 bits wide, is commonly used in machine learning, digital signal processing (DSP), and embedded systems due to its balanced trade-off between precision and memory usage.
The project was divided into two phases:
1.	Unpipelined MAC: A simple design that completes one MAC operation per clock cycle.
2.	Pipelined MAC: A six-stage pipelined version that enhances performance by allowing multiple MAC operations to be processed concurrently.
Both versions were implemented in Verilog, tested using a variety of floating-point test cases, and validated for accuracy. This report provides a comprehensive breakdown of the design process, testing results, encountered issues, and the role that Large Language Models (LLMs) like ChatGPT played in assisting the design and development process.

Half-Precision Floating-Point Format
The IEEE 754 half-precision floating-point format consists of 16 bits:
•	1 sign bit
•	5 exponent bits (biased by 15)
•	10 mantissa bits (with an implicit leading '1')

Unpipelined MAC Design
The unpipelined MAC was the first phase of the project. It was designed to perform multiplication and accumulation in a single clock cycle. The key components of the unpipelined MAC were:
•	Floating-Point Multiplier: This module takes two half-precision floating-point inputs, multiplies their mantissas, adds the exponents, and adjusts the product by normalizing the result and handling overflow/underflow cases.
•	Floating-Point Adder: This module adds the product from the multiplier to the accumulator. The addition involves aligning the exponents of both numbers by shifting the mantissas, performing the addition or subtraction depending on the signs of the inputs, and normalizing the result.

Unpipelined Multiplier
The multiplier works as follows:
1.	Extract the sign, exponent, and mantissa from both inputs.
2.	Multiply the mantissas.
3.	Add the exponents and adjust for the bias (15 for half-precision).
4.	Normalize the result by checking for any leading 1’s in the product.
5.	Assemble the result with the new sign, exponent, and mantissa.

Unpipelined Adder
The adder works as follows:
1.	Compare the exponents of both inputs and align them by shifting the mantissas of the smaller number.
2.	Add or subtract the mantissas, depending on the signs of the inputs.
3.	Normalize the result by adjusting the exponent and mantissa.
4.	Handle edge cases like underflow, overflow, and rounding.
5.	Verilog code for the floating-point adder:

Unpipelined MAC Architecture
The unpipelined MAC was a simple, direct combination of the multiplier and adder. The multiplication result is fed into the adder, which adds the result to the accumulator (third input). The result is produced in a single clock cycle, making this version suitable for designs where low latency is required but throughput is not critical.

Pipelined MAC Design
To improve performance and increase throughput, the second phase of the project was to implement a 6-stage pipelined MAC unit. The pipelined MAC breaks down the multiplication and addition processes into smaller steps, enabling multiple operations to be processed in parallel.
1. Pipeline Stages
The pipelined MAC is broken down into the following stages:
•	Multiplier Stages:
1.	Stage 1: Extract the sign, exponent, and mantissa of the inputs and multiply the mantissas.
2.	Stage 2: Add the exponents and compute the intermediate result.
3.	Stage 3: Normalize the product and adjust the exponent.
•	Adder Stages:
1.	Stage 4: Align the exponents of the product and the accumulator by shifting the mantissas.
2.	Stage 5: Add or subtract the aligned mantissas.
3.	Stage 6: Normalize the final result and handle rounding.

Pipelined Design
Each stage in the pipeline registers its intermediate results, allowing the next stage to begin processing a new set of inputs while the previous stages are still executing. This parallelism increases the throughput significantly, as a new operation can be initiated on every clock cycle, even though the final result takes several cycles to propagate through the pipeline.

Challenges in the Pipelined Design
The main challenge in implementing the pipelined MAC was ensuring that the intermediate results were correctly passed between the stages, especially when handling edge cases like:
•	Exponent alignment: Ensuring that the exponents were correctly aligned during the addition phase.
•	Normalization: Guaranteeing that the results were normalized after multiplication and addition.
•	Latency: Understanding and accounting for the inherent latency of the pipeline, where a result is delayed due to the multiple stages involved.

Test Cases
The following test cases were used for both the unpipelined and pipelined MAC:
1.	0.25 + 1.125 (0011_0100_0000_0000 + 0011_1010_0000_0000)
2.	150 - 250 (0101_0110_1100_0000 - 0110_0010_1100_0000)
3.	-2.5 × -7.25 (1100_0000_0010_0000 × 1100_0111_0100_0000)
4.	0.0001 + 0.00000001 (0001_1010_0101_1010 + 0000_0100_1011_0000)
5.	1024 - 8075 (0100_1010_0000_0000 - 0101_1111_1010_0011)
6.	2014 × 3.75 (0101_0111_1001_0111 × 0100_0000_1100_0000)

Comparison Between Unpipelined and Pipelined MAC
During the design and testing phases, key differences between the unpipelined and pipelined MAC units emerged:
•	Latency and Throughput:
o	Unpipelined MAC: Each operation (multiplication and addition) is processed sequentially, leading to longer delays and lower throughput. Only one result is produced at a time, making it less efficient for handling multiple operations.
o	Pipelined MAC: The pipelined MAC splits the computation into stages, allowing multiple operations to be processed simultaneously. After the pipeline is filled, a new result is produced every clock cycle, greatly increasing throughput and reducing delays.
•	Pipeline Stages:
o	Unpipelined MAC: Results are generated one at a time, as each operation must fully complete before the next can start.
o	Pipelined MAC: Operations are split across stages, enabling new operations to start while previous ones are still processing. This significantly reduces processing time and boosts performance.
•	Result Latency:
o	In the unpipelined MAC, results are delayed because operations are processed sequentially.
o	In the pipelined MAC, results appear consistently after the pipeline fills, improving efficiency.
The pipelined MAC is far superior for high-performance tasks, offering faster processing and higher throughput by overlapping operations. The unpipelined MAC, while simpler, is less efficient for applications requiring rapid, repeated computations.
