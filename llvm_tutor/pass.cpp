#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
// #include <iostream>
#include "llvm/Support/raw_ostream.h"

// for Automatically enable the pass
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

class TestClass : public llvm::FunctionPass {
public:
    virtual bool runOnFunction(llvm::Function &F) {
        llvm::StringRef r = F.getName();
        if ( r.startswith("hello")) {
            // std::cout  <<   "name starts with hello\n";
           llvm::errs() << "I saw a function called " << F.getName() << "!\n"; 
        }
        return false;
    }
    static char ID; // could be a global too
    TestClass(): FunctionPass(ID) {}
};

char TestClass::ID = 0 ;
// static llvm::RegisterPass<TestClass> global_("test_llvm", "test llvm", false, false);
// Automatically enable the pass.
// http://adriansampson.net/blog/clangpass.html
static void registerTestClass(const llvm::PassManagerBuilder &,
                         llvm::legacy::PassManagerBase &PM) {
  PM.add(new TestClass());
}
static llvm::RegisterStandardPasses
  RegisterMyPass(llvm::PassManagerBuilder::EP_EarlyAsPossible,
                 registerTestClass);
