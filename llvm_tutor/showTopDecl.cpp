#include "clang/Frontend/CompilerInstance.h"
#include <iostream>
#include "clang/Basic/SourceManager.h"
#include "clang/Lex/Preprocessor.h"
#include "clang/Basic/TargetOptions.h"

#include "clang/Basic/TargetInfo.h"


#include "clang/Parse/Parser.h"
#include "clang/AST/ASTConsumer.h" 
#include "clang/Parse/ParseAST.h" 

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


int main()
{
    CompilerInstance ci;
    DiagnosticConsumer *client = 0;
    ci.createDiagnostics( client, true  );

    // create TargetOptions
    std::shared_ptr<clang::TargetOptions> pTargetOptions = std::make_shared<clang::TargetOptions>();
    pTargetOptions->Triple = llvm::sys::getDefaultTargetTriple();
    // create TargetInfo
    TargetInfo *pti = TargetInfo::CreateTargetInfo(ci.getDiagnostics(), pTargetOptions);
    ci.setTarget(pti);

    ci.createFileManager();  // create FileManager
    ci.createSourceManager(ci.getFileManager()); // create SourceManager
    ci.createPreprocessor(clang::TU_Complete );  // create Preprocessor

    // + AST
    ci.createASTContext();
    auto astConsumer  = new CustomASTConsumer();
    ci.setASTConsumer( (std::unique_ptr<ASTConsumer>)astConsumer ) ;
    // end +AST 

    const FileEntry *pFile = ci.getFileManager().getFile("test.c");
    ci.getSourceManager().setMainFileID( 
        ci.getSourceManager().createFileID( pFile,  SourceLocation(), clang::SrcMgr::C_User  )
    ) ;
    // ci.getPreprocessor().EnterMainSourceFile();
    ci.getDiagnosticClient().BeginSourceFile(ci.getLangOpts(), &ci.getPreprocessor());
    
    // + AST
    clang::ParseAST( ci.getPreprocessor() , astConsumer , ci.getASTContext() );    
    // end +AST

    // removed ...
    ci.getDiagnosticClient().EndSourceFile();
}

