#include "clang/Parse/Parser.h"
#include "clang/AST/ASTConsumer.h" 
#include <iostream>

using namespace clang ;

class CustomASTConsumer : public ASTConsumer {
public:
 CustomASTConsumer () :  ASTConsumer() { }
    virtual ~ CustomASTConsumer () { }
    virtual bool HandleTopLevelDecl(DeclGroupRef decls)
    {
        clang::DeclGroupRef::iterator it;
        for( it = decls.begin(); it != decls.end(); it++)
        {
            clang::VarDecl *vd = llvm::dyn_cast<clang::VarDecl>(*it);
            if(vd)
               std::cout << vd->getDeclName().getAsString() << std::endl;;
        }
        return true;
    }
};


