# Unbabel Bakckend Engineering Challenge

#### Notes

+ **Tool and Language Used For Challenge:** Ruby version 2.6.1 

#### How to run the application
+ Step 1: Clone the repository to your local machine or any other desired machine using : git clone git@github.com:Nishant967/backend-engineering-challenge.git
+ Step 2: Run **bundle install**
+ Step 3: Make sure events.json file is there in the directory
+ Step 4: Run the cli using command: **ruby unbabel_cli.rb --input_file events.json --window_size 10**
+ Step 5: Check the output.json file for the results.

### Components of the application
+ TranslationDelivered class representing each line of events.json file and other attributes related to it.
+ Validator module for validating flag value given while launching application.
+ FileReadWrite module for performing read and write operation on file.
+ Utility for some generic implementations.
+ Aggregator for compiling final output data points.

#### Assumptions Made
+ Minimum value for window size is 1




