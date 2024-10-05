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

