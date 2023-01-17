# this module provides a simple way to print text before and after running a
# block of code in between. the purpose of this is to build CLI tools where you
# want to print something before starting a long-running step, and then print
# something when the long-running step is complete.
#
# usage:
#    > PrintWrap.print('Loading large file ...', ' DONE') do
#    >   IO.read('/tmp/some_very_large_file.txt')
#    > end
#   => Loading large file ...           # right before the block starts running
#   => Loading large file ... DONE      # when the block is complete
#
#    > PrintWrap.print('Waiting ...', ' OK') do
#    >   sleep 5
#    > end
#   => Waiting ...                      # before the sleep call
#   => Waiting ... OK                   # when the sleep is over
module PrintWrap
  # before: String you want printed before the block runs
  # after: String you want printed after the block runs
  def self.print(before, after)
    Kernel.print before     # necessary, otherwise the method will call itself
    block_result = yield if block_given?
    Kernel.puts after

    block_result
  end
end
